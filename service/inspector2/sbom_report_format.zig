pub const SbomReportFormat = enum {
    cyclonedx_1_4,
    spdx_2_3,

    pub const json_field_names = .{
        .cyclonedx_1_4 = "CYCLONEDX_1_4",
        .spdx_2_3 = "SPDX_2_3",
    };
};
