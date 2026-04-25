const std = @import("std");

pub const GroupBy = enum {
    resource_region,
    availability_zone_id,
    account_id,
    account_name,
    instance_family,
    instance_type,
    instance_platform,
    reservation_arn,
    reservation_id,
    reservation_type,
    reservation_create_timestamp,
    reservation_start_timestamp,
    reservation_end_timestamp,
    reservation_end_date_type,
    tenancy,
    reservation_state,
    reservation_instance_match_criteria,
    reservation_unused_financial_owner,

    pub const json_field_names = .{
        .resource_region = "resource-region",
        .availability_zone_id = "availability-zone-id",
        .account_id = "account-id",
        .account_name = "account-name",
        .instance_family = "instance-family",
        .instance_type = "instance-type",
        .instance_platform = "instance-platform",
        .reservation_arn = "reservation-arn",
        .reservation_id = "reservation-id",
        .reservation_type = "reservation-type",
        .reservation_create_timestamp = "reservation-create-timestamp",
        .reservation_start_timestamp = "reservation-start-timestamp",
        .reservation_end_timestamp = "reservation-end-timestamp",
        .reservation_end_date_type = "reservation-end-date-type",
        .tenancy = "tenancy",
        .reservation_state = "reservation-state",
        .reservation_instance_match_criteria = "reservation-instance-match-criteria",
        .reservation_unused_financial_owner = "reservation-unused-financial-owner",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_region => "resource-region",
            .availability_zone_id => "availability-zone-id",
            .account_id => "account-id",
            .account_name => "account-name",
            .instance_family => "instance-family",
            .instance_type => "instance-type",
            .instance_platform => "instance-platform",
            .reservation_arn => "reservation-arn",
            .reservation_id => "reservation-id",
            .reservation_type => "reservation-type",
            .reservation_create_timestamp => "reservation-create-timestamp",
            .reservation_start_timestamp => "reservation-start-timestamp",
            .reservation_end_timestamp => "reservation-end-timestamp",
            .reservation_end_date_type => "reservation-end-date-type",
            .tenancy => "tenancy",
            .reservation_state => "reservation-state",
            .reservation_instance_match_criteria => "reservation-instance-match-criteria",
            .reservation_unused_financial_owner => "reservation-unused-financial-owner",
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
