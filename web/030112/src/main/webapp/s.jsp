<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>A 창</title>
</head>
<body>
    <h2>A 창</h2>
    <!-- B 창 열기 위한 링크 -->
    <a href="B.html" target="_blank">B 창 열기</a>
    <!-- 값을 표시할 입력 필드 -->
    <input type="text" id="data_received" name="data_received" readonly>

    <!-- 자식 창으로부터 데이터를 받는 스크립트 -->
    <script>
        // 자식 창으로부터 데이터를 받는 함수
        function receiveDataFromChild(data) {
            // 받은 데이터를 입력 필드에 표시
            document.getElementById("data_received").value = data;
        }
    </script>
</body>
</html>
