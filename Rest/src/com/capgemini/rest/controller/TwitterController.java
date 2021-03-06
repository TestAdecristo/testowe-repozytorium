package com.capgemini.rest.controller;

import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.capgemini.NavigationNames;
import com.capgemini.persistence.domain.TwitterAccess;
import com.capgemini.rest.model.TwitterLoginForm;
import com.capgemini.service.TwitterAccessService;
import com.capgemini.service.UserService;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;

@Controller
public class TwitterController {

	@Autowired
	private Twitter twitter;

	@Autowired
	private TwitterAccessService twitterAccessService;

	@RequestMapping(method = RequestMethod.GET, value = "/twitter-login")
	public String getLoginPage(Model model, Principal user, HttpSession session) {
		try {
			TwitterAccess ta = twitterAccessService.findByLogin(user.getName());
			model.addAttribute("twitterLoginForm", new TwitterLoginForm());
			
			if (ta != null) {
				model.addAttribute("isAccessToken", true);
				model.addAttribute("accessToken", ta.getAccessToken());
				model.addAttribute("accessTokenSecret", ta.getAccessTokenSecret());
				twitter.setOAuthAccessToken(new AccessToken(
						ta.getAccessToken(), ta.getAccessTokenSecret()));
				session.setAttribute("connected", true);
			} else {
				RequestToken requestToken = twitter.getOAuthRequestToken();
				model.addAttribute("twitterAuthUrl",
						requestToken.getAuthorizationURL());
			}
		} catch (TwitterException ex) {
			ex.printStackTrace();
			model.addAttribute("error", true);
		}
		
		model.addAttribute("page", NavigationNames.CONNECT);
		return "twitter-login";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/twitter-login")
	public String getRegisterAccount(@ModelAttribute TwitterLoginForm tweet,
			Model model, Principal principal, HttpSession session) {
		try {
			AccessToken access = twitter.getOAuthAccessToken(tweet
					.getTwitterPin());
			model.addAttribute("isAccessToken", true);
			model.addAttribute("accessToken", access.getToken());
			twitterAccessService.addTwitterAccess(access.getToken(),
					access.getTokenSecret(), access.getUserId());
			session.setAttribute("connected", true);
		} catch (TwitterException e) {
			e.printStackTrace();
		}
		model.addAttribute("page", NavigationNames.CONNECT);
		return "twitter-login";
	}
}
