pragma solidity ^0.4.0;

contract ScienceContract{
    
    ICO myIco =  ICO(0xdc04977a2078c8ffdf086d618d1f961b6c546222);
    
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


contract ICO{
    
}