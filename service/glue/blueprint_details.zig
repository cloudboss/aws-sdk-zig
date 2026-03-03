/// The details of a blueprint.
pub const BlueprintDetails = struct {
    /// The name of the blueprint.
    blueprint_name: ?[]const u8 = null,

    /// The run ID for this blueprint.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .blueprint_name = "BlueprintName",
        .run_id = "RunId",
    };
};
