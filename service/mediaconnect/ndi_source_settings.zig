/// The settings for the NDI® source. This includes the exact name of the
/// upstream NDI sender that you want to connect to your source.
pub const NdiSourceSettings = struct {
    /// The exact name of an existing NDI sender that's registered with your
    /// discovery server. If included, the format of this name must be `MACHINENAME
    /// (ProgramName)`.
    source_name: ?[]const u8,

    pub const json_field_names = .{
        .source_name = "SourceName",
    };
};
