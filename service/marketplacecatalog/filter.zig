/// A filter object, used to optionally filter results from calls to the
/// `ListEntities` and `ListChangeSets` actions.
pub const Filter = struct {
    /// For `ListEntities`, the supported value for this is an
    /// `EntityId`.
    ///
    /// For `ListChangeSets`, the supported values are as follows:
    name: ?[]const u8,

    /// `ListEntities` - This is a list of unique `EntityId`s.
    ///
    /// `ListChangeSets` - The supported filter names and associated
    /// `ValueList`s is as follows:
    ///
    /// * `ChangeSetName` - The supported `ValueList` is a list of
    /// non-unique `ChangeSetName`s. These are defined when you call the
    /// `StartChangeSet` action.
    ///
    /// * `Status` - The supported `ValueList` is a list of
    /// statuses for all change set requests.
    ///
    /// * `EntityId` - The supported `ValueList` is a list of
    /// unique `EntityId`s.
    ///
    /// * `BeforeStartTime` - The supported `ValueList` is a list
    /// of all change sets that started before the filter value.
    ///
    /// * `AfterStartTime` - The supported `ValueList` is a list
    /// of all change sets that started after the filter value.
    ///
    /// * `BeforeEndTime` - The supported `ValueList` is a list of
    /// all change sets that ended before the filter value.
    ///
    /// * `AfterEndTime` - The supported `ValueList` is a list of
    /// all change sets that ended after the filter value.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value_list = "ValueList",
    };
};
