<?php

use Restserver\Libraries\REST_Controller;
use Restserver\Libraries\Veritrans;
defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
//To Solve File REST_Controller not found
require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';

/**
 * This is an example of a few basic user interaction methods you could use
 * all done with a hardcoded array
 *
 * @package         CodeIgniter
 * @subpackage      Rest Server
 * @category        Controller
 * @author          Phil Sturgeon, Chris Kacerguis
 * @license         MIT
 * @link            https://github.com/chriskacerguis/codeigniter-restserver
 */
class Users extends REST_Controller {

    function __construct()
    {
        // Construct the parent class
        parent::__construct();
		header('Content-Type: application/json');
		$this->load->database();
		
		error_reporting(E_ALL ^ E_NOTICE); 
		error_reporting(0);
		ini_set('display_errors', 0);	
		$this->var_global = array(
			'Auth' => '5e636b16-df7f-4a53-afbe-497e6fe07edc',
        );
		
	}
	
	public function login_post(){

	
		$username =$this->input->post('username');
		$password = $this->input->post('password');
		$loginTime = $this->input->post('loginTime');

		if(!empty($username) || !empty($password)){
			$getdata=$this->db->query("select * from user where username='".$username."' ");

			if($getdata->num_rows()){
				$row=$getdata->row();
				$u_password=$row->password;
				if($password==$u_password){
					$getdata=$this->db->query("update user SET login_time = '".$loginTime."', login_state = '1' where username='".$username."' ");
					
					$this->response([
						'status_code' => 200,
						'message' =>"success",
						'username' => $row->username,
						'login_time' =>$row->login_time,
						'login_state' =>$row->login_state,
					], REST_Controller::HTTP_OK);

				}else{
					 
					$this->response([
						'status_code' => 400,
						'message' =>"wrong password"
					], REST_Controller::HTTP_OK);

				}
				
			}else{

				$this->response([
					'status_code' => 400,
					'message' =>"email not register"
				], REST_Controller::HTTP_OK);

			}
			
		}else{
			$this->response([
				'status_code' => 400,
				'message' =>"empty params"
			], REST_Controller::HTTP_OK);
		}

	}
	
	public function login_get(){
		$data = array();
		$this->response([
			'status_code' => 404,
			'message' =>"not suppport method"
		], REST_Controller::HTTP_NOT_FOUND);
		
	}

	public function register_post(){
		$username =$this->input->post('username');
		$password = $this->input->post('password');

		if(!empty($username) || !empty($password)){
			
			$getdata=$this->db->query("select * from user where username='".$username."' ");

			if($getdata->num_rows()){
				$this->response([
					'status_code' => 400,
					'message' =>"wrong password"
				], REST_Controller::HTTP_OK);
				
			}else{
				$insertData=$this->db->query("insert into user(username, password)values('".$username."', '".$password."')");
				if($insertData) {
					$this->response([
						'status_code' => 200,
						'message' =>"success"
					], REST_Controller::HTTP_OK);
				} else {
					$this->response([
						'status_code' => 400,
						'message' =>"Failed insert data"
					], REST_Controller::HTTP_OK);
				}
				

			}
			
		}else{
			$this->response([
				'status_code' => 400,
				'message' =>"Data already exists"
			], REST_Controller::HTTP_OK);
		}

	}
	

}
