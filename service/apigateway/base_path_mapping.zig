/// Represents the base path that callers of the API must provide as part of the
/// URL after the domain name.
pub const BasePathMapping = struct {
    /// The base path name that callers of the API must provide as part of the URL
    /// after the domain name.
    base_path: ?[]const u8,

    /// The string identifier of the associated RestApi.
    rest_api_id: ?[]const u8,

    /// The name of the associated stage.
    stage: ?[]const u8,

    pub const json_field_names = .{
        .base_path = "basePath",
        .rest_api_id = "restApiId",
        .stage = "stage",
    };
};
