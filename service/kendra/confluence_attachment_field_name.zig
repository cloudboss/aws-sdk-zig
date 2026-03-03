const std = @import("std");

pub const ConfluenceAttachmentFieldName = enum {
    author,
    content_type,
    created_date,
    display_url,
    file_size,
    item_type,
    parent_id,
    space_key,
    space_name,
    url,
    version,

    pub const json_field_names = .{
        .author = "AUTHOR",
        .content_type = "CONTENT_TYPE",
        .created_date = "CREATED_DATE",
        .display_url = "DISPLAY_URL",
        .file_size = "FILE_SIZE",
        .item_type = "ITEM_TYPE",
        .parent_id = "PARENT_ID",
        .space_key = "SPACE_KEY",
        .space_name = "SPACE_NAME",
        .url = "URL",
        .version = "VERSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .author => "AUTHOR",
            .content_type => "CONTENT_TYPE",
            .created_date => "CREATED_DATE",
            .display_url => "DISPLAY_URL",
            .file_size => "FILE_SIZE",
            .item_type => "ITEM_TYPE",
            .parent_id => "PARENT_ID",
            .space_key => "SPACE_KEY",
            .space_name => "SPACE_NAME",
            .url => "URL",
            .version => "VERSION",
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
