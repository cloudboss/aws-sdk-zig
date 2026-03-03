/// A reference to a unique stage identified in the format
/// `{restApiId}/{stage}`.
pub const StageKey = struct {
    /// The string identifier of the associated RestApi.
    rest_api_id: ?[]const u8 = null,

    /// The stage name associated with the stage key.
    stage_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .rest_api_id = "restApiId",
        .stage_name = "stageName",
    };
};
