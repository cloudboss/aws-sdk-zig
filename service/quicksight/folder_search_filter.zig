const FolderFilterAttribute = @import("folder_filter_attribute.zig").FolderFilterAttribute;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A filter to use to search an Quick Sight folder.
pub const FolderSearchFilter = struct {
    /// The name of a value that you want to use in the filter. For example,
    /// `"Name": "QUICKSIGHT_OWNER"`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `QUICKSIGHT_VIEWER_OR_OWNER`: Provide an ARN of a user or group, and any
    ///   folders with that ARN listed as one of the folder's owners or viewers are
    ///   returned. Implicit permissions from folders or groups are considered.
    ///
    /// * `QUICKSIGHT_OWNER`: Provide an ARN of a user or group, and any folders
    ///   with that ARN listed as one of the owners of the folders are returned.
    ///   Implicit permissions from folders or groups are considered.
    ///
    /// * `DIRECT_QUICKSIGHT_SOLE_OWNER`: Provide an ARN of a user or group, and any
    ///   folders with that ARN listed as the only owner of the folder are returned.
    ///   Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_OWNER`: Provide an ARN of a user or group, and any
    ///   folders with that ARN listed as one of the owners of the folders are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_VIEWER_OR_OWNER`: Provide an ARN of a user or group,
    ///   and any folders with that ARN listed as one of the owners or viewers of
    ///   the folders are returned. Implicit permissions from folders or groups are
    ///   not considered.
    ///
    /// * `FOLDER_NAME`: Any folders whose names have a substring match to this
    ///   value will be returned.
    ///
    /// * `PARENT_FOLDER_ARN`: Provide an ARN of a folder, and any folders that are
    ///   directly under that parent folder are returned. If you choose to use this
    ///   option and leave the value blank, all root-level folders in the account
    ///   are returned.
    name: ?FolderFilterAttribute = null,

    /// The comparison operator that you want to use as a filter, for example
    /// `"Operator": "StringEquals"`. Valid values are `"StringEquals"` and
    /// `"StringLike"`.
    ///
    /// If you set the operator value to `"StringEquals"`, you need to provide an
    /// ownership related filter in the `"NAME"` field and the arn of the user or
    /// group whose folders you want to search in the `"Value"` field. For example,
    /// `"Name":"DIRECT_QUICKSIGHT_OWNER", "Operator": "StringEquals", "Value":
    /// "arn:aws:quicksight:us-east-1:1:user/default/UserName1"`.
    ///
    /// If you set the value to `"StringLike"`, you need to provide the name of the
    /// folders you are searching for. For example, `"Name":"FOLDER_NAME",
    /// "Operator": "StringLike", "Value": "Test"`. The `"StringLike"` operator only
    /// supports the `NAME` value `FOLDER_NAME`.
    operator: ?FilterOperator = null,

    /// The value of the named item (in this example, `PARENT_FOLDER_ARN`), that you
    /// want to use as a filter. For example, `"Value":
    /// "arn:aws:quicksight:us-east-1:1:folder/folderId"`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
