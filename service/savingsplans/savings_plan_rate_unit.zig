const std = @import("std");

pub const SavingsPlanRateUnit = enum {
    hours,
    lambda_gb_second,
    request,
    acu_hr,
    read_request_units,
    write_request_units,
    read_capacity_unit_hrs,
    write_capacity_unit_hrs,
    replicated_write_request_units,
    replicated_write_capacity_unit_hrs,
    gb_hours,
    dpu,
    elasti_cache_processing_unit,
    dcu_hr,
    ncu_hr,
    ocu_hrs,
    jobs,

    pub const json_field_names = .{
        .hours = "Hrs",
        .lambda_gb_second = "Lambda-GB-Second",
        .request = "Request",
        .acu_hr = "ACU-Hr",
        .read_request_units = "ReadRequestUnits",
        .write_request_units = "WriteRequestUnits",
        .read_capacity_unit_hrs = "ReadCapacityUnit-Hrs",
        .write_capacity_unit_hrs = "WriteCapacityUnit-Hrs",
        .replicated_write_request_units = "ReplicatedWriteRequestUnits",
        .replicated_write_capacity_unit_hrs = "ReplicatedWriteCapacityUnit-Hrs",
        .gb_hours = "GB-Hours",
        .dpu = "DPU",
        .elasti_cache_processing_unit = "ElastiCacheProcessingUnit",
        .dcu_hr = "DCU-Hr",
        .ncu_hr = "NCU-hr",
        .ocu_hrs = "OCU-hours",
        .jobs = "Jobs",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hours => "Hrs",
            .lambda_gb_second => "Lambda-GB-Second",
            .request => "Request",
            .acu_hr => "ACU-Hr",
            .read_request_units => "ReadRequestUnits",
            .write_request_units => "WriteRequestUnits",
            .read_capacity_unit_hrs => "ReadCapacityUnit-Hrs",
            .write_capacity_unit_hrs => "WriteCapacityUnit-Hrs",
            .replicated_write_request_units => "ReplicatedWriteRequestUnits",
            .replicated_write_capacity_unit_hrs => "ReplicatedWriteCapacityUnit-Hrs",
            .gb_hours => "GB-Hours",
            .dpu => "DPU",
            .elasti_cache_processing_unit => "ElastiCacheProcessingUnit",
            .dcu_hr => "DCU-Hr",
            .ncu_hr => "NCU-hr",
            .ocu_hrs => "OCU-hours",
            .jobs => "Jobs",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
