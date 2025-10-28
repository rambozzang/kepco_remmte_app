import 'package:lamp_remote_app/repo/data/user_info_data.dart';

class ResAdduserGraphqlData {
  static const String addUserDataQuery = r"""
        mutation AddUserRequest($direction: String!, $floor: Float!, $empno: String!, $phoneno: String) {
        addUserRequest(direction: $direction, FLOOR: $floor, EMPNO: $empno, PHONENO: $phoneno) {
          ok
          error
          msg
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
        }
      }
        """;
}


// mutation Mutation($deptName: String!, $phoneno: String!, $mailno: String!, $empno: String!, $name: String!, $direction: String!, $floor: Float!) {
//             addUserRequest(DEPT_NAME: $deptName, PHONENO: $phoneno, MAILNO: $mailno, EMPNO: $empno, NAME: $name, direction: $direction, FLOOR: $floor) {
//               error
//               ok
//               msg
//               userInfo {
//                 createdAt
//                 EMPNO
//                 DEPT_NAME
//                 MAILNO
//                 NAME
//                 PHONENO
//                 USER_POSITION {
//                   FLOOR
//                   direction
//                   id
//                 }
//                 id
//                 isApproval
//                 updatedAt
//               }
//             }
//           }