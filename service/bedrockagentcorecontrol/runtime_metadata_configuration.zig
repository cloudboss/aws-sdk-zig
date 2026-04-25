/// Configuration for microVM metadata service settings.
pub const RuntimeMetadataConfiguration = struct {
    /// Enables MMDSv2 (microVM Metadata Service Version 2) requirement for the
    /// agent runtime. When set to `true`, the runtime microVM will only accept
    /// MMDSv2 requests.
    require_mmdsv2: bool,

    pub const json_field_names = .{
        .require_mmdsv2 = "requireMMDSV2",
    };
};
