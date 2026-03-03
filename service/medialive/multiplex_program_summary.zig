/// Placeholder documentation for MultiplexProgramSummary
pub const MultiplexProgramSummary = struct {
    /// The MediaLive Channel associated with the program.
    channel_id: ?[]const u8 = null,

    /// The name of the multiplex program.
    program_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .program_name = "ProgramName",
    };
};
