/// Contains information about the last time an Amazon Web Services access key
/// was used since IAM began
/// tracking this information on April 22, 2015.
///
/// This data type is used as a response element in the
/// [GetAccessKeyLastUsed](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccessKeyLastUsed.html)
/// operation.
pub const AccessKeyLastUsed = struct {
    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the access key was most
    /// recently used. This field is null in the
    /// following situations:
    ///
    /// * The user does not have an access key.
    ///
    /// * An access key exists but has not been used since IAM began tracking this
    /// information.
    ///
    /// * There is no sign-in data associated with the user.
    last_used_date: ?i64 = null,

    /// The Amazon Web Services Region where this access key was most recently used.
    /// The value for this field
    /// is "N/A" in the following situations:
    ///
    /// * The user does not have an access key.
    ///
    /// * An access key exists but has not been used since IAM began tracking this
    /// information.
    ///
    /// * There is no sign-in data associated with the user.
    ///
    /// For more information about Amazon Web Services Regions, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html) in the
    /// Amazon Web Services
    /// General Reference.
    region: []const u8,

    /// The name of the Amazon Web Services service with which this access key was
    /// most recently used. The
    /// value of this field is "N/A" in the following situations:
    ///
    /// * The user does not have an access key.
    ///
    /// * An access key exists but has not been used since IAM started tracking this
    /// information.
    ///
    /// * There is no sign-in data associated with the user.
    service_name: []const u8,
};
