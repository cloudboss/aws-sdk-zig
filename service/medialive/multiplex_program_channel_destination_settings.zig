/// Multiplex Program Input Destination Settings for outputting a Channel to a
/// Multiplex
pub const MultiplexProgramChannelDestinationSettings = struct {
    /// The ID of the Multiplex that the encoder is providing output to. You do not
    /// need to specify the individual inputs to the Multiplex; MediaLive will
    /// handle the connection of the two MediaLive pipelines to the two Multiplex
    /// instances.
    /// The Multiplex must be in the same region as the Channel.
    multiplex_id: ?[]const u8 = null,

    /// The program name of the Multiplex program that the encoder is providing
    /// output to.
    program_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .multiplex_id = "MultiplexId",
        .program_name = "ProgramName",
    };
};
