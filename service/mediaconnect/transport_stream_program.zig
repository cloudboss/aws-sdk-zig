const TransportStream = @import("transport_stream.zig").TransportStream;

/// The metadata of a single transport stream program.
pub const TransportStreamProgram = struct {
    /// The Program Clock Reference (PCR) Packet ID (PID) as it is reported in the
    /// Program Association Table.
    pcr_pid: i32,

    /// The program name as it is reported in the Program Association Table.
    program_name: ?[]const u8 = null,

    /// The program number as it is reported in the Program Association Table.
    program_number: i32,

    /// The program Packet ID (PID) as it is reported in the Program Association
    /// Table.
    program_pid: i32,

    /// The list of elementary transport streams in the program. The list includes
    /// video, audio, and data streams.
    streams: []const TransportStream,

    pub const json_field_names = .{
        .pcr_pid = "PcrPid",
        .program_name = "ProgramName",
        .program_number = "ProgramNumber",
        .program_pid = "ProgramPid",
        .streams = "Streams",
    };
};
