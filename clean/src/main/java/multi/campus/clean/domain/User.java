package multi.campus.clean.domain;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	@NotEmpty(message="아이디를 입력하세요.")
	String userid;
	@NotEmpty(message="비밀번호를 입력하세요.")
	String passwd;
	@NotEmpty(message="비밀번호를 확인해주세요.")
	String passwdCheck;
	@Email(message="email 형식이 아닙니다.")
	String email;
	String address;
	String phone;
	int bin;
	double lat;
	double lon;
	Date regDate;
	Date updateDate;
}
