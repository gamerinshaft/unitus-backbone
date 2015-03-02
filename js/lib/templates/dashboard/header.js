define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (dashboard) {
buf.push("<h1 data-js=\"logoTitle\" class=\"text-center\">UNITUS</h1><div class=\"dropdown\"><div id=\"account\" data-js=\"dropdown\" data-toggle=\"dropdown\" aria-expanded=\"false\">" + (jade.escape(null == (jade_interp = dashboard.get('Name')) ? "" : jade_interp)) + "<span class=\"caret\"></span></div><ul role=\"menu\" aria-labelledby=\"account\" class=\"dropdown-menu\">");
if ( dashboard.get('IsAdministrator'))
{
buf.push("<li class=\"author menu\">管理者メニュー</li><li data-js=\"adminToggle\" class=\"item\">管理画面を開く</li><li class=\"divider\"></li>");
}
buf.push("<!-- (管理者用ここまで)--><li class=\"author menu\">アカウントメニュー</li><li data-js=\"setting\" class=\"item\">設定</li><li class=\"divider\"></li><li data-js=\"logout\" class=\"item\">ログアウト</li><li class=\"divider\"></li></ul></div>");}.call(this,"dashboard" in locals_for_with?locals_for_with.dashboard:typeof dashboard!=="undefined"?dashboard:undefined));;return buf.join("");
};

});
