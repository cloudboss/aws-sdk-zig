const MultiplexProgramSettings = @import("multiplex_program_settings.zig").MultiplexProgramSettings;
const MultiplexProgramPacketIdentifiersMap = @import("multiplex_program_packet_identifiers_map.zig").MultiplexProgramPacketIdentifiersMap;
const MultiplexProgramPipelineDetail = @import("multiplex_program_pipeline_detail.zig").MultiplexProgramPipelineDetail;

/// The multiplex program object.
pub const MultiplexProgram = struct {
    /// The MediaLive channel associated with the program.
    channel_id: ?[]const u8 = null,

    /// The settings for this multiplex program.
    multiplex_program_settings: ?MultiplexProgramSettings = null,

    /// The packet identifier map for this multiplex program.
    packet_identifiers_map: ?MultiplexProgramPacketIdentifiersMap = null,

    /// Contains information about the current sources for the specified program in
    /// the specified multiplex. Keep in mind that each multiplex pipeline connects
    /// to both pipelines in a given source channel (the channel identified by the
    /// program). But only one of those channel pipelines is ever active at one
    /// time.
    pipeline_details: ?[]const MultiplexProgramPipelineDetail = null,

    /// The name of the multiplex program.
    program_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .multiplex_program_settings = "MultiplexProgramSettings",
        .packet_identifiers_map = "PacketIdentifiersMap",
        .pipeline_details = "PipelineDetails",
        .program_name = "ProgramName",
    };
};
