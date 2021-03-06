<?php

/**
 * Description of UpdateContest
 *
 * @author joemmanuel
 */
class UpdateContestTest extends OmegaupTestCase {

	/**
	 * Only update the contest title. Rest should stay the same
	 */
	public function testUpdateContestTitle() {

		// Get a contest 
		$contestData = ContestsFactory::createContest();

		// Prepare request
		$r = new Request();
		$r["contest_alias"] = $contestData["request"]["alias"];

		// Log in with contest director
		$r["auth_token"] = $this->login($contestData["director"]);

		// Update title
		$r["title"] = Utils::CreateRandomString();

		// Call API
		$response = ContestController::apiUpdate($r);

		// To validate, we update the title to the original request and send
		// the entire original request to assertContest. Any other parameter
		// should not be modified by Update api
		$contestData["request"]["title"] = $r["title"];
		$this->assertContest($contestData["request"]);
	}

	/**
	 * 
	 * @expectedException ForbiddenAccessException
	 */
	public function testUpdateContestNonDirector() {

		// Get a contest 
		$contestData = ContestsFactory::createContest();

		// Prepare request
		$r = new Request();
		$r["contest_alias"] = $contestData["request"]["alias"];

		// Log in with contest director
		$r["auth_token"] = $this->login(UserFactory::createUser());

		// Update title
		$r["title"] = Utils::CreateRandomString();

		// Call API
		ContestController::apiUpdate($r);		
	}

}

