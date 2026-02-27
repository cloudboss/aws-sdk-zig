/// Nielsen Watermarks Distribution Types
pub const NielsenWatermarksDistributionTypes = enum {
    final_distributor,
    program_content,

    pub const json_field_names = .{
        .final_distributor = "FINAL_DISTRIBUTOR",
        .program_content = "PROGRAM_CONTENT",
    };
};
