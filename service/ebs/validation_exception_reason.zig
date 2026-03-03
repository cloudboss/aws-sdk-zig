const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_customer_key,
    invalid_page_token,
    invalid_block_token,
    invalid_grant_token,
    invalid_snapshot_id,
    unrelated_snapshots,
    invalid_block,
    invalid_content_encoding,
    invalid_tag,
    invalid_dependency_request,
    invalid_parameter_value,
    invalid_volume_size,
    conflicting_block_update,
    invalid_image_id,
    write_request_timeout,

    pub const json_field_names = .{
        .invalid_customer_key = "INVALID_CUSTOMER_KEY",
        .invalid_page_token = "INVALID_PAGE_TOKEN",
        .invalid_block_token = "INVALID_BLOCK_TOKEN",
        .invalid_grant_token = "INVALID_GRANT_TOKEN",
        .invalid_snapshot_id = "INVALID_SNAPSHOT_ID",
        .unrelated_snapshots = "UNRELATED_SNAPSHOTS",
        .invalid_block = "INVALID_BLOCK",
        .invalid_content_encoding = "INVALID_CONTENT_ENCODING",
        .invalid_tag = "INVALID_TAG",
        .invalid_dependency_request = "INVALID_DEPENDENCY_REQUEST",
        .invalid_parameter_value = "INVALID_PARAMETER_VALUE",
        .invalid_volume_size = "INVALID_VOLUME_SIZE",
        .conflicting_block_update = "CONFLICTING_BLOCK_UPDATE",
        .invalid_image_id = "INVALID_IMAGE_ID",
        .write_request_timeout = "WRITE_REQUEST_TIMEOUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_customer_key => "INVALID_CUSTOMER_KEY",
            .invalid_page_token => "INVALID_PAGE_TOKEN",
            .invalid_block_token => "INVALID_BLOCK_TOKEN",
            .invalid_grant_token => "INVALID_GRANT_TOKEN",
            .invalid_snapshot_id => "INVALID_SNAPSHOT_ID",
            .unrelated_snapshots => "UNRELATED_SNAPSHOTS",
            .invalid_block => "INVALID_BLOCK",
            .invalid_content_encoding => "INVALID_CONTENT_ENCODING",
            .invalid_tag => "INVALID_TAG",
            .invalid_dependency_request => "INVALID_DEPENDENCY_REQUEST",
            .invalid_parameter_value => "INVALID_PARAMETER_VALUE",
            .invalid_volume_size => "INVALID_VOLUME_SIZE",
            .conflicting_block_update => "CONFLICTING_BLOCK_UPDATE",
            .invalid_image_id => "INVALID_IMAGE_ID",
            .write_request_timeout => "WRITE_REQUEST_TIMEOUT",
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
