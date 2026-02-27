pub const SolutionSortName = enum {
    identifier,
    name,
    status,
    category,
    createddate,

    pub const json_field_names = .{
        .identifier = "IDENTIFIER",
        .name = "NAME",
        .status = "STATUS",
        .category = "CATEGORY",
        .createddate = "CREATEDDATE",
    };
};
