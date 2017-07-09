pragma solidity ^0.4.0;

contract ScienceContract{
    
    ICO myIco =  ICO(0xb87213121fb89cbd8b877cb1bb3ff84dd2869cfa);
    
    uint projectNum;
    uint mentorNum;
    uint studentNum;
    uint uniNum;
    uint paperNum;
    uint buyerNum;
    
    struct Wallet{
        address forReward;
        address forFunding;
    }
    
    struct Student{
        uint id;
        string name;
        uint8 age;
        uint researchScore;
        //Project[] projects_proposed;
        //Project[] projects_accepted;
        //Project[] projects_rejected;
    }
    
    
    struct Mentor{
        uint id;
        string name;
        string title;
        string university;
        string proficiency;
        uint researchScore;
    }
    
    struct University{
        uint id;
        string name;
        Project[] projects;
        
    }
    
    struct Project{
        uint id;
        string name;
        string summury;
        uint mentorVote;
        uint budget;
        bool isAccepted;
        Mentor[] mentors_voted;
        Student[] students;
    }
    
    struct Paper{
        uint id;
        uint positiveTrunstPoint;
        uint negativeTrustPoint;
        bool isUsed;
        bool isBought;
        uint projectId;
        uint refund;
    }
    
    struct Buyer{
        uint id;
        string name;
        Paper[] paper_bought;
    }
    
    event Status(string msg, address caller);
    
    //mapping(address => Student) studentAt;
    mapping(uint => Student) studentAt;
    mapping (uint => Mentor) mentorAt;
    mapping (uint => Project) projectAt;
    mapping (uint => University) universityAt;
    mapping (uint => Paper) paperAt;
    mapping (uint => Buyer) buyerAt;
    
    
    function createStudent(string _name, uint8 _age){
        
        //Project student = studentAt[msg.sender];
        Student student = studentAt[studentNum];
        student.id = studentNum;
        student.name = _name;
        student.age = _age;
        studentNum++;
        Status("Student created",msg.sender);
    }

    function getStudent(uint _id) constant returns (uint ,string , uint8,uint ){   
        return(studentAt[_id].id,studentAt[_id].name,studentAt[_id].age,studentAt[_id].researchScore);
    }
    
   
    function createMentor(string _name, string _title, string _university, string _proficiency){
        
        Mentor mentor = mentorAt[mentorNum];
        mentor.id = mentorNum;
        mentor.name = _name;
        mentor.title = _title;
        mentor.university = _university;
        mentor.proficiency = _proficiency;
        mentorNum++;
        Status("Mentor created",msg.sender);
        
    }
    
    function getMentor(uint _id) constant returns (uint ,string ,string,string,string,uint ){   
        return(mentorAt[_id].id,mentorAt[_id].name,mentorAt[_id].title,
        mentorAt[_id].university,mentorAt[_id].proficiency,mentorAt[_id].researchScore);
    }

    
    function createProject(string _name,string _summury,uint _budget){
        
        Project project = projectAt[projectNum];
        project.id = projectNum;
        project.name = _name;
        project.summury = _summury;
        project.budget = _budget;
        project.mentorVote = 0;
        project.isAccepted = false;
        projectNum++;
        Status("Project created",msg.sender);
    }
    
     function createUniversity(string _name){
        
        University uni = universityAt[uniNum];
        uni.id = uniNum;
        uni.name = _name;
        uniNum++;
        Status("University created",msg.sender);
    } 
     
     
    function createPaper(uint _projectId){
        
        Paper paper = paperAt[paperNum];
        paper.id = paperNum;
        paper.projectId = _projectId;
        paper.isUsed = false;
        paper.isBought = false;
        paperNum++;
        Status("Paper created",msg.sender);   
    }
    
    function getPaper(uint _id) constant returns (uint ,bool , bool,uint ){   
        return(paperAt[_id].id,paperAt[_id].isUsed,paperAt[_id].isUsed,paperAt[_id].refund);
    }

    function fundPaper(uint _paperId){
        Paper paper = paperAt[_paperId];
        //Come from ICO
        //paper.refund
        ////////
    }


    function createBuyer(string _id, string _name){
        
        Buyer buyer = buyerAt[buyerNum];
        buyer.id = buyerNum;
        buyer.name = _name;
        buyerNum++;
        Status("Buyer created",msg.sender);
    } 
    
    function proposeProject(uint _studentId, uint _projectId){

        Project project = projectAt[_projectId];
        project.isAccepted = false;
        Student student = studentAt[_studentId];
        project.students.push(student);
     }
     
    function voteProject(uint _projectId, uint _mentorId){
         Project project = projectAt[_projectId];
         Mentor tmp_mentor = mentorAt[_mentorId];
         project.mentors_voted.push(tmp_mentor);
         project.mentorVote++;
         
     }
     
     function isProjectSuccess(uint _projectId) returns(bool){
         Project project = projectAt[_projectId];
         project.isAccepted = project.mentorVote*2 > mentorNum;
         return project.isAccepted;
     }
     
    

    //  function sendProjectToUniversity(uint _projectId, uint _universityId){
    //      Project tmp_project = projectAt[_projectId];
    //      if(tmp_project.isProjectSuccess()){
    //          University university = universityAt[_universityId];
    //          university.projects.push(tmp_project);
    //          Status("Project is sent to the university",msg.sender);

    //      }
                 
    //  }
    
    function buyPaper(uint _paperId, uint _buyerId){
         Paper tmp_paper = paperAt[_paperId];
         Buyer buyer = buyerAt[_buyerId];
         buyer.paper_bought.push(tmp_paper);
         
         //increaseMentorTrustPoint(_mentorId);
         //increaseStudentTrustPoint(_studentId);    
     }
     
     function increaseStudentResearchScore(uint _id){
         Student student = studentAt[_id];
         student.researchScore++;
         //studentAt[_id].researchScore ++;
     }
     
     function increaseMentorResearchScore(uint _id){
        Mentor mentor = mentorAt[_id];
        mentor.researchScore++;
     }
    


    
    
}  


pragma solidity ^0.4.8;
    
   // ----------------------------------------------------------------------------------------------
   // Sample fixed supply token contract
   // Enjoy. (c) BokkyPooBah 2017. The MIT Licence.
   // ----------------------------------------------------------------------------------------------
    
   // ERC Token Standard #20 Interface
   // https://github.com/ethereum/EIPs/issues/20
  contract ERC20Interface {
     // Get the total token supply
      function totalSupply() constant returns (uint256 totalSupply);
      
      // Get the account balance of another account with address _owner
      function balanceOf(address _owner) constant returns (uint256 balance);
   
      // Send _value amount of tokens to address _to
      function transfer(address _to, uint256 _value) returns (bool success);
   
      // Send _value amount of tokens from address _from to address _to
      function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
   
      // Allow _spender to withdraw from your account, multiple times, up to the _value amount.
      // If this function is called again it overwrites the current allowance with _value.
      // this function is required for some DEX functionality
      function approve(address _spender, uint256 _value) returns (bool success);
   
      // Returns the amount which _spender is still allowed to withdraw from _owner
      function allowance(address _owner, address _spender) constant returns (uint256 remaining);
   
      // Triggered when tokens are transferred.
      event Transfer(address indexed _from, address indexed _to, uint256 _value);
   
      // Triggered whenever approve(address _spender, uint256 _value) is called.
      event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  }
   
  contract ICO is ERC20Interface {
      string public constant symbol = "FIXED";
      string public constant name = "Example Fixed Supply Token";
      uint8 public constant decimals = 18;
      uint256 _totalSupply = 1000000;
      
      // Owner of this contract
      address public owner;
   
      // Balances for each account
      mapping(address => uint256) balances;
   
      // Owner of account approves the transfer of an amount to another account
      mapping(address => mapping (address => uint256)) allowed;
   
      // Functions with this modifier can only be executed by the owner
      modifier onlyOwner() {
          if (msg.sender != owner) {
              throw;
          }
          _;
      }
   
      // Constructor
      function FixedSupplyToken() {
          owner = msg.sender;
          balances[owner] = _totalSupply;
      }
   
      function totalSupply() constant returns (uint256 totalSupply) {
          totalSupply = _totalSupply;
      }
   
      // What is the balance of a particular account?
      function balanceOf(address _owner) constant returns (uint256 balance) {
          return balances[_owner];
      }
   
      // Transfer the balance from owner's account to another account
      function transfer(address _to, uint256 _amount) returns (bool success) {
          if (balances[msg.sender] >= _amount 
              && _amount > 0
             && balances[_to] + _amount > balances[_to]) {
              balances[msg.sender] -= _amount;
              balances[_to] += _amount;
              Transfer(msg.sender, _to, _amount);
              return true;
          } else {
              return false;
          }
      }
   
      // Send _value amount of tokens from address _from to address _to
      // The transferFrom method is used for a withdraw workflow, allowing contracts to send
      // tokens on your behalf, for example to "deposit" to a contract address and/or to charge
      // fees in sub-currencies; the command should fail unless the _from account has
      // deliberately authorized the sender of the message via some mechanism; we propose
      // these standardized APIs for approval:
      function transferFrom(
          address _from,
          address _to,
          uint256 _amount
     ) returns (bool success) {
         if (balances[_from] >= _amount
             && allowed[_from][msg.sender] >= _amount
             && _amount > 0
             && balances[_to] + _amount > balances[_to]) {
             balances[_from] -= _amount;
             allowed[_from][msg.sender] -= _amount;
             balances[_to] += _amount;
             Transfer(_from, _to, _amount);
             return true;
         } else {
             return false;
         }
     }
  
     // Allow _spender to withdraw from your account, multiple times, up to the _value amount.
     // If this function is called again it overwrites the current allowance with _value.
     function approve(address _spender, uint256 _amount) returns (bool success) {
         allowed[msg.sender][_spender] = _amount;
         Approval(msg.sender, _spender, _amount);
         return true;
     }
  
     function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
         return allowed[_owner][_spender];
     }
 }
