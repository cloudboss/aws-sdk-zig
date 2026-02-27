pub const CisScanResultDetailsSortBy = enum {
    check_id,
    status,

    pub const json_field_names = .{
        .check_id = "CHECK_ID",
        .status = "STATUS",
    };
};
