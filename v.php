<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * 观点: 对白, 跟帖
 * @copyright vragon
 * @version 4.0
 * @author
 */
class View extends FD_Controller {

    function __construct() {
        parent::__construct();
        $this->load->model('View_model');
    }

    /**
     * 获取一栋楼的默认对白和置顶对白
     */
    public function fetch_one_build() {
        $build_id = $this->input->post('build_id', true);
        $world_id = $this->input->post('world_id', true);
        if (empty($build_id)) {
            $build_id = 1;
            $world_id = 1;
        }
        $world_id = (int) $world_id;
        $build_id = (int) $build_id;
    
        $build_up = $this->View_model->getBuildDialog($world_id, $build_id);
        _fill_as_json(1, $build_up);
    }
    
    /**
     * 发布新的对白
     */
    public function create_dialog() { // User
        $account_num = $this->user->is_login();
        
        $abs_path = $this->_check_path($this->input->post('abs_path', true));
        $is_anno = $this->input->post('is_anno', true);
        //上半句
        $dialog_up = $this->input->post('dialog_up', true);
        //下半句
        $dialog_down = $this->input->post('dialog_down', true);
    
        $has_create = $this->View_model->add_dialog($account_num, $abs_path, $dialog_up, $dialog_down, $is_anno);
    
        if ($has_create) {
            _fill_as_json(1, array('status' => 1, 'msg' => '对白发布成功', 'dialog_id' => $has_create));
        } else {
            _fill_as_json(1, array('status' => -1, 'msg' => '对白发布失败'));
        }
    }
    
    /**
     * 顶一条对白
     */
    public function ding() {
        $account_num = $this->user->is_login();
        
        $propId = $this->input->get_param('propId', true); // 道具id
        $dialogId = $this->input->get_param('dialogId', true); // id
        $dialogType = $this->input->get_param('dialogType', true);
        $viewModel = new View_model();
        $boolean = $viewModel->ding($dialogId, $dialogType, $propId, $account_num);
        if ($boolean) {
            _fill_as_json(1, array('status'=>1, 'msg'=>'顶对白成功'));
        } else {
            _fill_as_json(1, array('status' => -1, 'msg' =>'顶对白失败'));
        }
    }
    
    /**
     * 获取一段时间内最新一条对白
     */
    public function getNewOne() {
        $absPath = $this->input->get_param('absPath');
        $viewModel = new View_model();
        $row = $viewModel->getNewByAbsPath($absPath);
        if (empty($row)) {
            _fill_as_json(1, array('status'=>-1, 'msg'=>'没有新的对白'));
        } else {
            _fill_as_json(1, array('status'=>1, 'msg'=>'获取对白成功', 'data'=>$row));
        }
    }
    
    /**
     * 某个元素(房间)，对白列表（按更新时间排序）
     */
    public function fetch_meta_dialog() {
        _check_param_from_page();
    
        $abs_path = $this->_check_path($this->input->post('abs_path', true));
//         $dialog_list = $this->View_model->get_dialog_list_by_path($abs_path, $_POST['num_per_req'], $_POST['down_num']);
        $viewModel = new View_model();
        $result = $viewModel->batchLoad($abs_path, $_POST['num_per_req'], $_POST['down_num']);

        _fill_as_json(1, $result);
    }
    
    /**
     * 获取用户的对白
     */
    public function fetch_dialog() {
        $dialog_id = $this->input->post('dialog_id', true);

        _fill_as_json(1, $this->View_model->get_dialog_from_meta($dialog_id));
    }
    
    /**
     * 删除对白
     */
    public function del() {
    	$accountNum = $this->user->is_login();
    	$id = $this->input->get_param('id');
    	$viewModel = new View_model();
    	$boolean = $viewModel->del($id, $accountNum);
    	if ($boolean) {
    		_fill_as_json(1, array('status'=>1, 'msg'=>'删除对白成功'));
    	} else {
    		$error = $viewModel->getError();
    		if (empty($error)) {
    			$error = '删除对白失败';
    		}
    		_fill_as_json(1, array('status'=>-1, 'msg'=>$error));
    	}
    }
    
    /**
     * 检查参数: 对白所在路径
     */
    private function _check_path($path) {
    	if (!is_numeric(str_replace('_', '', $path))) {
    		_fill_as_json(0);
    	}
    
    	return $path;
    }   
    
    
    
    
    /**
     * 获取原始和置顶对白
     *  
     */
    public function fetch_ori_up() {
        //路径: 栋_楼层_房间_情景
//         $abs_path = $this->_check_path($this->input->post('abs_path', true));
//         //原始和置顶对白
//         $ori_up_dialog = $this->View_model->get_ori_up_dialog($abs_path);

//         _fill_as_json(1, $ori_up_dialog);
    }

    /**
     * 获取我的对白列表 
     */
    public function fetch_me_dialog() {
        _check_param_from_page();

        $account_num = $this->input->post('account_num', true);

        _fill_as_json(1, $this->View_model->get_dialog_from_account($account_num, $_POST['num_per_req'], $_POST['down_num']));
    }

    /**
     * 对白的跟帖
     */
    public function create_follow() {
        $account_num = $this->user->is_login();
        $dialog_id = $this->input->post('dialog_id', true);
        $follow_content = $this->input->post('content', true);

        $has_follow = $this->View_model->dialog_add_follow($account_num, $dialog_id, $follow_content);

        if ($has_follow) {
            _fill_as_json(1, array('status' => 1, 'msg' => '跟帖成功', 'follow_id' => $has_follow));
        } else {
            _fill_as_json(1, array('status' => -1, 'msg' => '跟帖失败'));
        }
    }

    /**
     * 回复跟帖 
     */
    public function create_reply() {
        $account_num = $this->user->is_login();
        $follow_id = $this->input->post('follow_id', true); //盖楼最后一条记录的跟帖id 或者是被回复的跟帖id
        $reply_content = $this->input->post('content', true);

        $has_reply = $this->View_model->dialog_add_follow_reply($account_num, $follow_id, $reply_content);

        if ($has_reply) {
            _fill_as_json(1, array('status' => 1, 'msg' => '回复成功', 'follow_id' => $has_reply));
        } else {
            _fill_as_json(1, array('status' => -1, 'msg' => '回复失败'));
        }
    }

    /**
     * 跟帖/回复的赞 
     */
    public function follow_favor() {
        $account_num = $this->user->is_login();
        $follow_id = $this->input->post('follow_id', true);
        $has_favor = $this->View_model->dialog_follow_favor($account_num, $follow_id);

        if ($has_favor == 1) {
            _fill_as_json(1, array('status' => 1, 'msg' => '赞他成功'));
        } elseif ($has_favor == 0) {
            _fill_as_json(1, array('status' => 0, 'msg' => '已赞过, 取消赞'));
        } else {
            _fill_as_json(1, array('status' => -1, 'msg' => '赞他失败'));
        }
    }

    /**
     * 最热跟帖
     */
    public function fetch_follow_hot() {
        $dialog_id = $this->input->post('dialog_id', true);
        $follow_hot = $this->View_model->get_dialog_hot_follow($dialog_id);

        _fill_as_json(1, $follow_hot);
    }

    /**
     * 最新跟帖
     */
    public function fetch_follow_new() {
        _check_param_from_page();

        $dialog_id = $this->input->post('dialog_id', true);
        $follow_new = $this->View_model->get_dialog_new_follow($dialog_id, $_POST['num_per_req'], $_POST['down_num']);

        _fill_as_json(1, $follow_new);
    }

    /**
     * 我的跟帖  
     */
    public function fetch_me_follow() {
        _check_param_from_page();

        $account_num = $this->input->post('account_num', true);
        if ($account_num === FALSE) {
            $account_num = $this->user->is_login();
        }

        $me_follow = $this->View_model->get_dialog_follow_about_me($account_num, $_POST['num_per_req'], $_POST['down_num']);

        _fill_as_json(1, $me_follow);
    }

    /**
     * 回复我的 
     */
    public function fetch_reply_me() {
        _check_param_from_page();

        $account_num = $this->user->is_login();

        $reply_me = $this->View_model->get_dialog_follow_reply_me($account_num, $_POST['num_per_req'], $_POST['down_num']);

        _fill_as_json(1, $reply_me);
    }

    /**
     * 世界跟帖(系统推荐)
     */
    public function fetch_world_follow() {
        _check_param_from_page();

        $account_num = $this->user->is_login();

        $world_id = $this->input->post('world_id', true);

        $world_follow = $this->View_model->get_dialog_world_follow($account_num, $world_id, $_POST['num_per_req'], $_POST['down_num']);

        _fill_as_json(1, $world_follow);
    }

    /**
     * 置顶对白最新五条跟帖,不含盖楼 
     */
    public function fetch_follow() {
        $dialog_id = $this->input->post('dialog_id', true);
        $meta_follow = $this->View_model->get_meta_dialog_follow($dialog_id);

        _fill_as_json(1, $meta_follow);
    }
    




}

/* End of file view.php */
/* Location: ./application/controllers/view.php */