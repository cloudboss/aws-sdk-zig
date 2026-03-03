const std = @import("std");

pub const CodegenGenericDataFieldDataType = enum {
    id,
    string,
    int,
    float,
    aws_date,
    aws_time,
    aws_date_time,
    aws_timestamp,
    aws_email,
    aws_url,
    aws_ip_address,
    boolean,
    aws_json,
    aws_phone,
    @"enum",
    model,
    non_model,

    pub const json_field_names = .{
        .id = "ID",
        .string = "String",
        .int = "Int",
        .float = "Float",
        .aws_date = "AWSDate",
        .aws_time = "AWSTime",
        .aws_date_time = "AWSDateTime",
        .aws_timestamp = "AWSTimestamp",
        .aws_email = "AWSEmail",
        .aws_url = "AWSURL",
        .aws_ip_address = "AWSIPAddress",
        .boolean = "Boolean",
        .aws_json = "AWSJSON",
        .aws_phone = "AWSPhone",
        .@"enum" = "Enum",
        .model = "Model",
        .non_model = "NonModel",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .id => "ID",
            .string => "String",
            .int => "Int",
            .float => "Float",
            .aws_date => "AWSDate",
            .aws_time => "AWSTime",
            .aws_date_time => "AWSDateTime",
            .aws_timestamp => "AWSTimestamp",
            .aws_email => "AWSEmail",
            .aws_url => "AWSURL",
            .aws_ip_address => "AWSIPAddress",
            .boolean => "Boolean",
            .aws_json => "AWSJSON",
            .aws_phone => "AWSPhone",
            .@"enum" => "Enum",
            .model => "Model",
            .non_model => "NonModel",
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
