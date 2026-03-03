const Program = @import("program.zig").Program;

/// Type-specific filters for program management accounts.
pub const ProgramManagementAccountTypeFilters = struct {
    /// Filter by program types.
    programs: ?[]const Program = null,

    pub const json_field_names = .{
        .programs = "programs",
    };
};
