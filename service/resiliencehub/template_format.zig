pub const TemplateFormat = enum {
    cfn_yaml,
    cfn_json,

    pub const json_field_names = .{
        .cfn_yaml = "CFN_YAML",
        .cfn_json = "CFN_JSON",
    };
};
