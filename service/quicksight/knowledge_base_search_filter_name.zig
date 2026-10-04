const std = @import("std");

/// The name of a field that you can use to filter knowledge base search
/// results. Valid values include:
///
/// * `DATASOURCE_ARN` – The Amazon Resource Name (ARN) of the associated data
///   source.
///
/// * `DIRECT_QUICKSIGHT_OWNER` – An Amazon QuickSight user or group with direct
///   owner permissions.
///
/// * `DIRECT_QUICKSIGHT_SOLE_OWNER` – An Amazon QuickSight user or group that
///   is the sole direct owner.
///
/// * `DIRECT_QUICKSIGHT_VIEWER_OR_OWNER` – An Amazon QuickSight user or group
///   with direct viewer or owner permissions.
///
/// * `KNOWLEDGE_BASE_ID` – The unique identifier of the knowledge base.
///
/// * `KNOWLEDGE_BASE_NAME` – The display name of the knowledge base.
///
/// * `KNOWLEDGE_BASE_SIZE_BYTES` – The size of the knowledge base in bytes.
///
/// * `PRIMARY_OWNER` – The Amazon Resource Name (ARN) of the primary owner of
///   the knowledge base.
pub const KnowledgeBaseSearchFilterName = enum {
    knowledge_base_id,
    knowledge_base_name,
    direct_quicksight_owner,
    direct_quicksight_viewer_or_owner,
    direct_quicksight_sole_owner,
    knowledge_base_size_bytes,
    primary_owner,
    datasource_arn,

    pub const json_field_names = .{
        .knowledge_base_id = "KNOWLEDGE_BASE_ID",
        .knowledge_base_name = "KNOWLEDGE_BASE_NAME",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .knowledge_base_size_bytes = "KNOWLEDGE_BASE_SIZE_BYTES",
        .primary_owner = "PRIMARY_OWNER",
        .datasource_arn = "DATASOURCE_ARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .knowledge_base_id => "KNOWLEDGE_BASE_ID",
            .knowledge_base_name => "KNOWLEDGE_BASE_NAME",
            .direct_quicksight_owner => "DIRECT_QUICKSIGHT_OWNER",
            .direct_quicksight_viewer_or_owner => "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
            .direct_quicksight_sole_owner => "DIRECT_QUICKSIGHT_SOLE_OWNER",
            .knowledge_base_size_bytes => "KNOWLEDGE_BASE_SIZE_BYTES",
            .primary_owner => "PRIMARY_OWNER",
            .datasource_arn => "DATASOURCE_ARN",
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
