define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;
;var locals_for_with = (locals || {});(function (achivement) {
buf.push("<div class=\"optionbar\"><div data-js=\"closePanel\" class=\"close_btn\"><div class=\"glyphicon glyphicon-remove-sign\"></div></div><div class=\"option_title\">Achivement<span>（実績）</span></div></div><div class=\"main\">" + (jade.escape(null == (jade_interp = achivement.get("Name")) ? "" : jade_interp)) + "</div>");}.call(this,"achivement" in locals_for_with?locals_for_with.achivement:typeof achivement!=="undefined"?achivement:undefined));;return buf.join("");
};

});
