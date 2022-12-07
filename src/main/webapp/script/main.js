/**
 * 
 */
      
                            window.onload = function () {


                                let list_check = $("#subway_div label");

                                for (let i = 0; i < list_check.length; i++) {
                                    list_check[i].addEventListener("click", function (e) {
                                        let target = event.target;
                                        alert(target);

                                        alert($(target).text());
                                        var bookmark_nm = $(target).text();




                                        let label_for = target.parentNode.getAttribute("for");
                                        alert(label_for);
                                        let bookmark_value = $(`input[id=${label_for}]`).val();
                                        alert(bookmark_value);

                                        $.ajax({

                                            url: "${contextPath}/bookmark_process.jsp",
                                            type: "post",
                                            dataType: "json",
                                            data: {
                                                station_cd: bookmark_value
                                            }

                                        });

                                        //$("#bookmarked_div").append(`<div id='${bookmark_nm}'>${bookmark_nm}</div>`);
                                        //alert($("#bookmarked_div").text());

                                        function bookmark_update(){
                                            let list_bookmarked = new Array();
                                            list_bookmarked = $("#bookmarked_div").children();
                                            let alredy_in;
                                            let same_class;

                                            for (let i = 0; i < list_bookmarked.length; i++) {
                                                console.log("중요");
                                                console.log(bookmark_nm);
                                                console.log(list_bookmarked[i].className);


                                                if (bookmark_nm == list_bookmarked[i].className) {
                                                    same_class = list_bookmarked[i].className;
                                                    alredy_in = true;
                                                }

                                            }

                                            console.log("같은 이름 :" + same_class);

                                            if (alredy_in) {
                                                let list_children = $("#bookmarked_div").children();

                                                for (let i = 0; i < list_children.length; i++) {
                                                    if (list_children[i].className == same_class) {
                                                        list_children[i].remove();
                                                    }
                                                }
                                            } else {
                                                $("#bookmarked_div").append(`<div class='${bookmark_nm}'>⭐${bookmark_nm}</div>`);
                                            }

                                        }

                                        bookmark_update();

                                    })
                                }










                                //==========
                                $('#btn_addBookmark').off('click').on('click', function () {
                                    alert("test");

                                    if ($('#pop').css('display') == 'none') {
                                        $('#btn_addBookmark').attr("value", "-")
                                        console.log($('#btn_addBookmark').val());
                                        $('#pop').show();
                                    } else {
                                        $('#btn_addBookmark').attr("value", "+")
                                        $('#pop').hide();
                                    }

                                });
                                //===============

                                //=============

                                $('#memo_submit').off("click").on("click", function () {

                                    alert("a");

                                    let memo_contents = $("#memo_contents").val();
                                    console.log("memo: " + memo_contents);
                                    $.ajax({
                                        url: "${contextPath}/memo_process.jsp",
                                        type: "POST",
                                        dataType: "json",
                                        data: {
                                            memo_contents: memo_contents,
                                            process_name: "insert_memo"
                                        }
                                    });
                                })




                            }
                      