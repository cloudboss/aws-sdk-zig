pub const TargetResourceType = enum {
    asset,
    computation_model,

    pub const json_field_names = .{
        .asset = "ASSET",
        .computation_model = "COMPUTATION_MODEL",
    };
};
