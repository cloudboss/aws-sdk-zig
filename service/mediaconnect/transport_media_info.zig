const TransportStreamProgram = @import("transport_stream_program.zig").TransportStreamProgram;

/// The metadata of the transport stream in the current flow's source.
pub const TransportMediaInfo = struct {
    /// The list of transport stream programs in the current flow's source.
    programs: []const TransportStreamProgram,

    pub const json_field_names = .{
        .programs = "Programs",
    };
};
