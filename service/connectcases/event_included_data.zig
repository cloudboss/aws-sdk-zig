const CaseEventIncludedData = @import("case_event_included_data.zig").CaseEventIncludedData;
const RelatedItemEventIncludedData = @import("related_item_event_included_data.zig").RelatedItemEventIncludedData;

/// Details of what case and related item data is published through the case
/// event stream.
pub const EventIncludedData = struct {
    /// Details of what case data is published through the case event stream.
    case_data: ?CaseEventIncludedData,

    /// Details of what related item data is published through the case event
    /// stream.
    related_item_data: ?RelatedItemEventIncludedData,

    pub const json_field_names = .{
        .case_data = "caseData",
        .related_item_data = "relatedItemData",
    };
};
