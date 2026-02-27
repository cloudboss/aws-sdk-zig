pub const WorkflowExport = enum {
    definition,
    readme,

    pub const json_field_names = .{
        .definition = "DEFINITION",
        .readme = "README",
    };
};
