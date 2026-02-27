/// Video Selector Program Id
pub const VideoSelectorProgramId = struct {
    /// Selects a specific program from within a multi-program transport stream. If
    /// the program doesn't exist, the first program within the transport stream
    /// will be selected by default.
    program_id: ?i32,

    pub const json_field_names = .{
        .program_id = "ProgramId",
    };
};
