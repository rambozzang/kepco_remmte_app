class ResLoginGraphqlData {
  static const String resLoginData = r"""
          mutation Mutation($password: String!, $empno: String!) {
          login(PASSWORD: $password, EMPNO: $empno) {
            ok
            error
            msg
            type
            userInfo {
              USER_ID
              FRST_REG_DT
              FRST_REGR_EMPNO
              LST_CHG_DT
              LST_CHGR_EMPNO
              SMS_RCVR_TEL_NO
              POSITION {
                LOC_ID
                FRST_REG_DT
                FRST_REGR_EMPNO
                LST_CHG_DT
                LST_CHGR_EMPNO
                FLOR_CNT
                LOC_CL_NM
              }
              LOC_ID
              APR_USER_CFM_YN
              MNGR_AUTH_YN
              SYS_MNGR_YN
              KEPCO_USER_TBL {
                SSO_ID
                FRST_REG_DT
                FRST_REGR_EMPNO
                LST_CHG_DT
                LST_CHGR_EMPNO
                SSO_USER_NM
                SSO_EMPNO
                MAIN_EMAIL_ADDR
                SSO_CERT_KEY
                DEPT_NM
              }
              SSO_ID
            }
            url
          }
        }
        """;
}


// mutation Mutation($password: String!, $empno: String!) {
//             login(PASSWORD: $password, EMPNO: $empno) {
//               ok
//               error
//               msg
//               type
//               userInfo {
//                 id
//                 isApproval
//                 NAME
//                 EMPNO
//                 MAILNO
//                 PHONENO
//                 DEPT_NAME
//                 createdAt
//                 updatedAt
//                 POSITION {
//                   id
//                   FLOOR
//                   direction
//                 }
//                 pOSITIONId
//               }
//               url
//             }
//           }