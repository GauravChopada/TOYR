import 'package:flutter/material.dart';

import 'Log_In_Screen.dart';

enum AuthType { Login, SignUp }

class AuthScreen extends StatelessWidget {
  static const Routename = './AuthScreen';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          child: Image.network(
            // 'https://image.freepik.com/free-psd/online-shopping-with-laptop-mockup-template-shopping-elements_1150-38886.jpg',
            //'https://cdn.pixabay.com/photo/2017/08/05/00/12/girl-2581913_960_720.jpg',
            //'https://cdn.pixabay.com/photo/2014/11/27/22/43/gift-548285_960_720.jpg',
            // "https://previews.123rf.com/images/bitontawan02/bitontawan021408/bitontawan02140800013/30494969-reise-hintergrund-muster.jpg",
            "https://i.pinimg.com/564x/33/d0/a8/33d0a824fa331f551e400368ac57f87e.jpg",
            // "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUSExMVFRUVFRcWFhYVGRUVFxUYFhYWFxgXGBgYHSggGBolHRUYITEhJSkrLi4uFx8zODMtNygtLysBCgoKDg0OGxAQGysmICY1LS0tLS0vLS0tLS0vLy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAOkA2AMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAAAAQIEBQYDB//EAEAQAAEDAQUFBwEGBAQHAQAAAAEAAhEDBBIhMVEFBkFhcRMiMoGRscGhQlJyktHwYrLC4SMzQ/EHFBUWU2PiJP/EABoBAAIDAQEAAAAAAAAAAAAAAAADAQIEBQb/xAAzEQABAwIDBAoDAAIDAQAAAAABAAIRAyEEEjETQVFhBRRxgZGhscHh8CJS0TJiI0LxFf/aAAwDAQACEQMRAD8Apa3id1PumJ1bxO6n3XIuXQXAXRC5glPBQhKhCEKEISFEoQlQm3ksoQlQkSoQhCEIQhIlXJyELohNaExCF2QkCVCEIQhCEIQmlCE5CbHJCEJyEIQhOreJ3U+6Yn1vE7qfdMQpKAlSBKhQhCEIQkKJSoQhJCEqEISJUIQhC5FEodmhSAugRCAlQoSQiEqEISJUIQhCEiEISppTlIsFnLnthsi9jGPWVVzg1pcdyZSpmq8MbqbfezVRZQM1pbdsK++81wa2JPXhCobXSDXFrTIEY5cMUmjiWVbDWJI4d+i14zo2thZc+MswDIvvmNdNeBsuSEiVaFgTq3id1PumJ9bxO6n3TEKSlQkSOchQnITL6VpQhOQkSoQhCEIQhIlSIQmPau9OzOPA+QVlsGwOrOuiIb3p4dFt7BsxlOMJdrp0HBA0kn77KXSCABPE6AdmpJ8BzXmj2EZiE1b7eex03sOH+KBIgS4gZgxwjXJYEhAnepOXce3klSKRRsbnZDz4eqk2rY1Zjb7mm7qOHXTzRulQBJyjXhInwmVXprk4ppCFCRwQwpSFIpbPqlt4NkHSPZVc9rf8jCbTpVKsim0ui9gTbuXBWuytpPaW0xiCY5DGfNLsnZV4lzxIHDEAnyyUC0tuVCBwOHJZ3Op1yaWpAnlOnut9KnicE1mJnKHGCN5HMERBi03tMCxWrte0KTTcccx6/osnaqQY4huXAjHHoudR5cZJknimow+G2N57eE+qOkekut2yAAE5T/2jQg6i9jblqhKhC1Llp1bxO6n3TE+t4ndT7q33VsofVL3CRSExq4mG+0+STiKzaNJ1R2gHjy79E6jRdWqCm3UmPvYLrts7dskB1ZxYDiGN8cc5warE7v2X7r+t7H0yVk4zikHPJePq9J4qo7NnI5CwHv3klexo9FYWm2MgPM3P3sWY2pu0WNL6Li9oxLSO+Brhg5VlTZNdjGVXUXinU8DiDDpEj1GI1Xr9m2zZmM7NtOpdOeDTM8T3k2174U6Ra0We0PloI7NjCBmI8WBwXewWMcRs3vD3ctefI9sDnxXGxvRzGnO1paPEfHZ4LxmUq9Zq7ZpVg9rtm2oir4yaVNpdhAJcXDEcDOELDWndW0Go7sqFRtOTc7R1IODeAd3811G1AdbeC5VTDOaJbfsBWfKYtIzcy0nPsm9Xj+mV3p7kVPtVqQ6Xnf0q2YJWyfw9AsslWvZuOONpHlSJ93BSKe5VEeKtUP4Wtb7kont8EbM8vEexKqtzrc2nUc1xADhmfvDEfP0WtdVLhI7jOLzxHmoFHdSyt/8AM7q9o/lai1bFqOwFcloyFQXiPMEXjzhWab3H3sUVWEt/EieFxPfE+Hio20Nqsp03NpDMFt84lxI54lZSzUA97Wg4ucGebiB8rdWHYdJmNQdsTh3x3R0bMesp+1NnsNM9jTpse0te0ta1pJaZiQJxUVDmNh8qcO3I2HkE8hAHCNO8m5T9n7LZSAgS4cf7KRaa7W9094n7Gc+WnMqJZ9ods0lpDGjx3ovNPEFvD94KDadqspgil51HZnl3sT+8E4NL7/8Ag9h2arK+o2iMgt3SSeTdXE8Tbt1Wdt+x6hrPZTpuJBHdaCYvC80Exph5JWbq2w/6BHV1Nvu5avd+g8NdVfN6qQROdwCGT+9FapF9x8lsOUxIM77jXwPlbgsMzcy1HPsm/ie3+mVZWPY9WzDvvpuBMANc69jnm0COK06rrXZajql4ObEQJnAccNZWbFsc6nlAk27ua6XRNSnTxGdzgwAGSTr/AK9+vERa6iKl2hsini4GCczN4Dqru1UXUsXd5p+0BEHRYraNQl5aZIBwAwiVgw9GptC0HKRrv4dxXe6RxeH6s2q5gqNcbbrwZMkZhHIA7rTKilBQVzDV2l4ldEJUIQnVvE7qfdaHc53+c3iQw+QLp9x6rPVvE7qfdXW6e2KFme99Wi6qS0NbBADRjekHOe76LLjaBr4d1MamPIg+y14KsKOIbUOgJ8IIWmdTIAJBAORIIB6HintouIvBri0ZkAkDzyV83eWhWpgimajNMO6RwI4Fdqe8tNoDRScABAAIwC8r1XDh5aaunIyDz++G/wBi3E1XNDm05nmIhZdWlicQ2ASPP96p+0KlOs4ObTLD9rLvaYDLqkaIWzojCk4g1QZa2YO4k8Oy887Xlc3pjFjYilo4wSOA7uO5PLjqUiVrSchKd2R0jqvTzC8zlJ3JiE7snaFd7Mxn2jieGIhQXQFZtMkxp22UcNJyBKQhXbRAgKHtF4ywnjqltq5nRC0VMKGMzEqAhCfSol2XDMnJNJA1WUAkwExCkOsThoei607EeOeuf0hV2jeKaKFQmIVHbdkUqhvObDvvMJaT1jPzTbNsSiwh0Oe4ZGoS+Ogy+i0QsQ4+fD6KSxgGQASzVG4JzcK86mFSkIa2cldloOYTXNaO8RHNG3ncrHB/7KmQrQWhrjAxPMRh5qPXtQggN5TgrB5O5JdRY0Tn8vlZ3e1xFje4GC2pSM9X3f6l52TxXpO8jJsdoGjQ78lRjvhebK4AkpNQnK0Ta9ucn2shCVCslIQhCEJa/id1PumynV/Eep902UKSulC0uYbzHXTqCR/uvULOAWMf9+mx/wCZoJXlML1HY7pstA/+oD8st+Eirh6VVwNRjXdoB9QtFGrUYwhjiNNCRx4QrOxWYOn4/VSDZKeU49VAa6MkhKuWHcYHcrCqwC7ZPHiranZ2tylOfSB/sothrkm6dMP0U1Z3SHXW+kWPZYWVbbrc2mQHEUw4wCTExnCkWui4jDGPr++qp97djvrGi9hAuuLHzwY+Jd5ED1VlXrgC40YNEA48MExt4y671nfLc4qf42y3ueIiLR3ym1LW4iMjxI4qO15GSCZxSJwaAIhY3VHOMk3XajSDsJx4D9VNFMhoBIGXDH/dR7EMCYGHE8F0NF47wMnnGH74+SU83iVrothmaCZ4cPXwUjtRkJnnI/mQMTBOIzAmB1PH94JjWGe+GdczyCe6A6TnEckmAtQceztQ0QY4EehH7+i6LmSHeEgkGf35SEpk4ZdDif0VUyUrqgHPWOHXRUW89pIZTc2makPE0+Dr3dBwkEgkYcyrt9RrRpyVW6ocYOBOStsRVaWu0NuHmLpFXEGkQRr3LjQYWtAJxAg9eI6cE9CFsAhcsmTKjbUbes9dutGr9GE/C8tC9cuXg5v3mub6tI+Vid0NkUqlHtqjb+IaGyQB3QSTGZxWfEYhmHaaj+QtxPl4lPpUHVy1jf8AbXgIWaSq33n2cyjVApzdeA4A4lskiOmCp0yjWbWptqN0N0irSdSeWO1CVCEJqWnVvEep9ymJ9bxHqfdMQpKF6Ruu+bHR5do30qOPyvN16Dua+bI0fdqPHqGO+VB1CuzR3Z7hXKEIUqEoMZKxs1rBgHAqFRol2SStSLTBSn5XHKdVppbSm3aDT79lSa1R4mfDJw1UE04yP76J7KhHQ5jgrOlZ2wJbjGPFBOzClrDWNjpxuqnHl7JMdB6/2U+vYfu+h+FEqUy0wRCs1zXaJNSk9n+Q/isbHT7rTn7A9NVIVNTqkZGJUmxVzegkmcuqS+kblbKWJaYaR/FPcJwUe1VXNHDSeJ5wpKqrW4lxngY6KtJslMxL8jbamySz1brgfVI6ob16cZzXNC1ZRMrm5zly96mVi55DYE5zyKjvBPAykFY4csAeMaLrZ7O52Mxz/RUAyi6cTtXWkk9n3vXAhIpdqY+6L2PDp581FVmmRKVUbldHqulmPfb5Ly2wW+rZi5tN8QS0iAQbpLcjxwXp1M4jqFga+wqr7TXEXWCtU7ztDUcRdHHDyS6xpwdrGXn9urMzwCwmQd3MfCk7O2Q61NNor1T3jdbABJiR0AkEQFzfupUDngvbA8B4uwkSPs/VXOyndk11FovtYTF4wZJk8rs8FIs1qNS8XCHAwYXFOKxLKjspAZuECwtEDdbXttujomjh3U2yDn3m9zvk776Lz1zSCQRBBgjQhCuN52U+1ljgSfGBwI49Tpy5oXcpP2jA4Wlch7cji2VU1vE7qfdMT63id1PuubimKpSrc7iO/wDz1BpVB/M2P6ViKbC7wgu6An2XpG7GyBQs94uN+qGOcwwLkTAAzmHYzoqPIETxTqLS6Y4FWCF3FNt2b3e0RZacuHr6I2jeKv1epIEa/bp9p2c9zQ1tZ9KMTcDZJ5k8OQhRbaKjW0xUcHPEguAi8AcHRwJGY1lXapdsul4GgH1/YSaMl62YqG0jHIJFY2K0T3TmBmq5S9mjvE8k2qAW3WXDOIqADerAmMSqi01LzieHBd7baZ7oy4n4URVpMi5V8VWDjlGgQn0X3XA6FMQnFZQSDIV094AJ4Qqo1u6RxOZ8lzLyREmNEiUymBqtFbEF+lvlCEITVmQCrJ9taMsfhVqFRzA7VNp1nUwQ3erN9paWkzwOBzVUag1CKnhPRQmtkwFixFd2HcA0TPFaGjrAl25SnV2jjPSVU22yufVe8OuhziRBdlwVmKDeL9MhgLwJGJI0+q5VKRGPDXpmOq59evVqRmi3D/0rbhycPJp7+MH1WdqNcHHvSZzIn3XKv2jmFgddBMktwLupmfRXdjoA1nyARjniJc4Y+6nf9MpGQWwRxaSPpKxOxezdfd2L0DqWDfAcy5AMiN4nt0uvNK9C48smY8uAPyhTN4KIZaKrWkkAjPPFoJHkSR5IXqKL89NrzvAPiF4iuGNrPaBYEgdkmFBr+J3U+69E2NsWiylTJpNLyxpc5wDjeIBME5eS87tA7zup91ZVt7rW0ABzDwxYOHRTUaXCyZh6jGOJcvSGgDAYdMEq8zbvvbP4PyH4V5urvTWtFfsqjWRccQWtcDLRPFxERKRsnBbxiWExdbBS9ntzPkqsWrkrjZxlgOpP6fCh1NzdVNOvTqGGn1UlU9pYHOLuftkrSu+GkqrVQSDITHNDhDgn1mNABaTzBS2ercmQcRhh+q5p1qrlwGExpzhObUzfi5ZKlDIS9m7dHcVyQuxsz+IjqQPdcajmN8VSm38VRg+U7O3isYpP/U+CEqiv2pZm52mj5ODvZOt+0qNAB1Z5aHYAhj3knPJoMeaq6oNyYzDkyX2A7FI9Eipn74WMZOrO6U4/nIUZ2+tGcKdUjUhg+l8qA9/6qxo0tz/Q+hWiQqWlvZZjm57erSf5ZUvaG1i2zGvZxTqAY98OPdGByIxGh0KnacQVUUAZIcDH3RT0LDv33tXAWdv4abvl5U/dreG0161ypWhoDnXWsptvERhIbe4zgeCpWrbKm6o4WAlRSpNqPDGuubaLU3CeBUOkYDiM4A1wnHPyUHeq2VW2cPbVqU3B4ENeRenMYHz8iuuzK5NOm/MuY0mcZkCZ1xXJrYkYim2qBFy307itwodXqGmTNgVYuvG/DRwIN0HiI5ZFNrh3eLpxa04690fJ9U8ic78xdMtnPwjhjPRc7S0wYENBAzBJIAAy0B+qU7Q/eKaqa1Wo03kAgFzRIPEYjI9F0Ztp7WmWNIAJwkZKh3xp9+m7VpHoQflUIcRgMBoms6Mp16YeTrrb3B4LQ3pttL/jfSBgQDN9LT+PuulrtBqPdUOb3kkaSZhC4pV3QABAFl5uSbkp1bxO6n3TE+t4ndT7piEFCsNg7RFnrtqlpcGhwLRAJvNLePVQEATgMSVBEoBymQtfV34b9myA83ViPoKZ91vNl1L1Gm8tDS6m1xaMQ0uaHETxiV5TZt27S8f5d0auIb9M/ovWKIuNaDkymJjkAPPIrPVItBXSwgfJLhHcB6ALHf8AEPempZnU6NG5eLS995t6BMMgTng70Cy1HfK2NcHuLag4suhvpdxB9VUbY2gbVaalYz33YA/ZY3BrfQDzlImNpiIIWepiHFxLSvQNj742etDXHsX/AHXkXSeT8vWCtCvHXUmnMfqp+yttWizQGOv0x/pvxEfw8W+XoqOo8E2njdzx3rcbU3coVHGsWAuiSDk7nGqi2LYNne4h1JsR9mW6aFPG8Da9nlrXNc7AtPCDDseIwjzUzd6SHE8gPquP0hXexrsriCBFieIC6+GoU3gS0EG+guuTd1LMHSGu/CTLco4qFtih/wAywBxgtJunOJIzAiZAWnrOhpOgJ9As7TyHQLHgcZiHSXPJiIm/qnVsJQAyhgE6wI9FnXbuVBk9p6yP1XCpsSsPsg9CPmFrqbCSAOKtLPZg3mdV28PWr1TujiQuRisPhqI3zwB/oIXmr9n1RnTd5StbY7O6nYH0iJqOD+6MfEYwOWWKtbfZo7w8x8o2S3Fx5R6/7JWMxr6AOdote1pv3puDwdKp+THG9r3j0XmYT6dQtIc0kEGQRgQeRXqdawUneKnTd1a0/CzFbZFFw8F06tJEeWSjD9L060y0iOw8fuiXV6HqMiHg+I/vqs1a7dVqx2jy+MpOA8slst2qv+BTP3ZH5XH9Fh69K65zT9kkehVjYNsOpsuCcycIGa1YqhnpBtMCxBEW3LDRqllQl8851XoLrc4yIEGfIcBhpErlWtpMyQJgHoOZxWEqbcef7uJUZ206h0HQfqsowVc6uWk4xqvN7nNLGEEEhxGBBzH/AMrLp9otT3CC6R5Lk0roYelsqYYsVV+d2ZPQhCelJ1bxO6n3TE+t4ndT7piFJQu9jtBpvbUABLTIBykawuCEIBgyrqvvxaAYDKf5Xfqrpn/EWkQxrqbxea3tXNiGuAAIa3MtmTPTNYtMfTBzS9k3gtDcVUG9areiwWepTNtoObiWh93J5cQMuD5OIWYAXCpQwIaSAYJEmCRlI810pAwJzVmggQl1Xh5zAQnBqVCQqyUdFsNnWcdjTBHAHnjj8rQ7Gpww9fYBVNBkNaNAB6BXezmxTHOT9V5HpB0sJ4n+r2WGblgcAk2s6KNTm0j82Hys3QeQRzWg20JpXdXD6G9/SqalZ4M5lJwLTknmugK1NlJzXand6clIY8ggjMK3oVQ4SPPkqynR19E17S0rr4bFGkSNQvPYiizEWBgjf7KZbbUILRiTmdE7ZAwceYHoP7qtVtssdzqT+nwsXSdd1RknktmCoNpfi1d7U6GOP8J9lRK52i6KZ5wPqqOs+GuOgJ9BKz9Hj8DzP8T65ErFWp8vJ1JPqSuSQJV7ICLLxczc70ISoQhIUIQhCVCEIQnVvE7qfdci5da3id1PuuaFKVqVIEqFCEISIQhCLyEIQullpy9o1IHrAXNTNkMmtTH8U+gJ+FV5hpPb6K9NuZ7RxIHmtir2ythjfwj2VDC0QC8Z0gfxaPu7+r2dAXJVftg4NHMn0EfKhWciealbXPeaNB7n+ygp+Eb/AMI+70muMxIU1Ne2RimMrCMVyqVCU4NKwMpOJ4c0xXVgEU2/hn1x+VSOMAlaCiyGgaAD0Cx9IH8Wjn7fK6lAXJUTazu6Bz+CqDatSKNQ6NI9cPlXe13eEdT7LObxOiiRq5o+s/C19Gt/Fg4n3+Fnxr8rXngD6f1ZUJUiVepXkkISEpC5CE5CQFKhCEIQhCdW8Tup90yE+t4ndT7piFJSoSIQoSppSpChCEBCAhCVS9mWkU6rXnISDyBESoiFDmhwLTvVmOLHBw1C3VjtVNzmw5pxHEarSjFePp9OoW+ElvmR7LiYroYViCKkRxE+hHouzS6ZLNWeBj2916LtM/4h5AD5+VFWMG0qo/1H+ZJXdm2q4+0D1aPiFdnRtRjA0EGFf/6tJxuD5f32WsQszS3iqfaaw9JHyV3bvKPtUj5OB9wFU4OsN3mEwY/Dn/t5H5V/EkDUgepAWiWKs+8FG80uLmgOBMicuhPGFoaO8NmflWb5h7f5guT0hhq+Yfg6ANwJ81uw+KoGQHtntHombVd3+gHys1vO/uMGpJ9BCvLVbKb3ktqMIwycDwCy28Nqa97Q0yGg4jKTGXoF0ujaRBYI0E9lli6RqgUnQdbDxVSlSIXfXnEj0hOCchCE1iekQhCVCRKhCKzhediMz7pl4ahYKzWYvcGNALnYAYCTGWPE5Dmug2fUuNqCk4sfk4NJGLiwCQMCXCAMzI1CVtF0Ooj9vL5W5vDUIvDULFP2PXF3/Aqd4EgCm4kBpumQBIgxnqNQu1HYFZzO0uNY0uDG9q5tIvdDXQxryC7BzThnIiUbUI6iP28vla+8NQi8NQsbaNhWhji11mqyKhpYU3kOqAkXGkCHOwOATn7Brti/SLJaXS8FobDqjbjiR3XzSfDTj3UbUI6iP28vla/DX6pbw1C89ujQJbo0CnackdR/28vleg3hqEXhqF59dGgRdGgRtOSjqI/by+V6DeGoS3hqF57dGgRdGgRtOSnqI/by+V6DeGoReGoXn10aBF0aBG05KOoj9vL5XoN4ahBI1C8+ujQIujQI2nJT1H/by+V6DeGoReGoXn10aBF0aBG05KOoj9vL5XoN4ahF4ahefXRoEl0aBG0R1Aft5fK9CvDUIvDULz26NAiByRtOSnqI/by+V6FeGoReGoXnt0aBF0aBG05KOoj9vL5XoV4ahF4aheewOSW6NAjaclPUR+3l8r0G8NQlXnl0aBIjaclHUR+3l8rpTqFpDmmHNIc06EGQfUK8dvM+ZFNjYMMDcmsNwGmcLxEMGILcSTjhFChKXQVpR2q1rWsFHusc1zJebwLHOey84NF4B1SpIgSHjK6Cpdj3nfTNVzWd+qTJL6nZ4sDO9RBDahGJaTkTOMBUCEQhag75vlxFnpgvDqb+9UxovfUqOpiCLpvVX98YgRxkmv2ptztqFKz9k1rKF7sYcXOYHve57SSO8DeZnl2QjMhU6FEBCEIQpUIQhCEIQhCEIQhCEIQhCEIQhCEIUnZ9tdScXNDSS0t7wkDEFrh/E1zWuHMKMhCFdf8AX8Z/5azRMx2YAycBgPxH0bpi7/uIloaaFBwDnOaCzBt4uIa0TAaL5EZniVRoRClW9bbd65NnoC41zRDYEPkxE8C4xpjrKdU29IcBZ6DbwgFjA1zDj32uzDsR6BUyEQhaEb2VRMU6eLi6e8XCXufEzlL3ESMCZXP/ALorRAawQSW+KGS1wIaL2UuJjpoqJCICFJ2lbDWqvqloaXkEhswIaBhPSfNCjIQoX//Z",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
            top: size.height * 0.15,
            left: size.width * 0.05,
            //
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello !',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Welcome to TOYR App.',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )
              ],
            )),
        Positioned(
            top: size.height * 0.6,
            left: size.width * 0.1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LogInScreen.Routename,
                        arguments: AuthType.Login);
                  },
                  child: Card(
                    //color: Colors.deepPurple,
                    color: Colors.blue,
                    elevation: 7,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LogInScreen.Routename,
                        arguments: AuthType.SignUp);
                  },
                  child: Card(
                    //color: Colors.deepPurple[50],
                    color: Colors.blue[50],
                    elevation: 7,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        )),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ],
            ))
      ],
    ));
  }
}
