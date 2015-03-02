define(["jade"],function(jade){

return function template(locals) {
var buf = [];
var jade_mixins = {};
var jade_interp;

buf.push("<section id=\"main\" role=\"tabpanel\"><section id=\"header\" data-js=\"header\"></section><section id=\"panel\" data-js=\"panel\"><div id=\"basicUser\" data-js=\"basic\"></div><div id=\"adminUser\" data-js=\"admin\" class=\"hidden_panel_l\"></div></section></section><div id=\"settingModal\" data-js=\"settingModal\" class=\"modal fade\"><div class=\"modal-dialog\"><div class=\"modal-content\"><div class=\"modal-header\"><button type=\"button\" data-dismiss=\"modal\" aria-label=\"Close\" class=\"close\"><span aria-hidden=\"true\">&times;</span></button><h4 id=\"settingModalLabel\" class=\"modal-title\">Modal title</h4></div><div class=\"modal-body\">...</div><div class=\"modal-footer\"><button type=\"button\" data-dismiss=\"modal\" class=\"btn btn-default\">Close</button><button type=\"button\" class=\"btn btn-primary\">Save changes</button></div></div></div></div>");;return buf.join("");
};

});
