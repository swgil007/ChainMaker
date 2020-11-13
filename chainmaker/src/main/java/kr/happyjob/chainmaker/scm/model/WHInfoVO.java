package kr.happyjob.chainmaker.scm.model;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@EqualsAndHashCode(of = {"ware_no"})
public class WHInfoVO {
  
  private int totalcnt;
  
  private int ware_no;
  private String ware_name;
  private String ware_address;
  private String ware_dt_address;
  private String ware_zipcode;
  
  private String user_id;
  private String name;
  private String user_tel1;
  private String user_tel2;
  private String user_tel3;
  private String user_email;
  
}
