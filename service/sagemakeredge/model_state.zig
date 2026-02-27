pub const ModelState = enum {
    deploy,
    undeploy,

    pub const json_field_names = .{
        .deploy = "Deploy",
        .undeploy = "Undeploy",
    };
};
