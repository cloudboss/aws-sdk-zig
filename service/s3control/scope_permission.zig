const std = @import("std");

pub const ScopePermission = enum {
    get_object,
    get_object_attributes,
    list_multipart_upload_parts,
    list_bucket,
    list_bucket_multipart_uploads,
    put_object,
    delete_object,
    abort_multipart_upload,

    pub const json_field_names = .{
        .get_object = "GetObject",
        .get_object_attributes = "GetObjectAttributes",
        .list_multipart_upload_parts = "ListMultipartUploadParts",
        .list_bucket = "ListBucket",
        .list_bucket_multipart_uploads = "ListBucketMultipartUploads",
        .put_object = "PutObject",
        .delete_object = "DeleteObject",
        .abort_multipart_upload = "AbortMultipartUpload",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get_object => "GetObject",
            .get_object_attributes => "GetObjectAttributes",
            .list_multipart_upload_parts => "ListMultipartUploadParts",
            .list_bucket => "ListBucket",
            .list_bucket_multipart_uploads => "ListBucketMultipartUploads",
            .put_object => "PutObject",
            .delete_object => "DeleteObject",
            .abort_multipart_upload => "AbortMultipartUpload",
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
