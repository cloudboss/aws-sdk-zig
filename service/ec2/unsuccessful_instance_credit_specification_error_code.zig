const std = @import("std");

pub const UnsuccessfulInstanceCreditSpecificationErrorCode = enum {
    invalid_instance_id,
    instance_not_found,
    incorrect_instance_state,
    instance_credit_specification_not_supported,

    pub const json_field_names = .{
        .invalid_instance_id = "InvalidInstanceID.Malformed",
        .instance_not_found = "InvalidInstanceID.NotFound",
        .incorrect_instance_state = "IncorrectInstanceState",
        .instance_credit_specification_not_supported = "InstanceCreditSpecification.NotSupported",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_instance_id => "InvalidInstanceID.Malformed",
            .instance_not_found => "InvalidInstanceID.NotFound",
            .incorrect_instance_state => "IncorrectInstanceState",
            .instance_credit_specification_not_supported => "InstanceCreditSpecification.NotSupported",
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
