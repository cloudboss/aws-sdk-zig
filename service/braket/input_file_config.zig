const DataSource = @import("data_source.zig").DataSource;

/// A list of parameters that specify the input channels, type of input data,
/// and where it is located.
pub const InputFileConfig = struct {
    /// A named input source that an Amazon Braket hybrid job can consume.
    channel_name: []const u8,

    /// The MIME type of the data.
    content_type: ?[]const u8 = null,

    /// The location of the input data.
    data_source: DataSource,

    pub const json_field_names = .{
        .channel_name = "channelName",
        .content_type = "contentType",
        .data_source = "dataSource",
    };
};
