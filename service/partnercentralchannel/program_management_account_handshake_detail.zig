const Program = @import("program.zig").Program;

/// Details specific to program management account handshakes.
pub const ProgramManagementAccountHandshakeDetail = struct {
    /// The program associated with the handshake.
    program: ?Program = null,

    pub const json_field_names = .{
        .program = "program",
    };
};
