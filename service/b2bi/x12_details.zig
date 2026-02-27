const X12TransactionSet = @import("x12_transaction_set.zig").X12TransactionSet;
const X12Version = @import("x12_version.zig").X12Version;

/// A structure that contains the X12 transaction set and version. The X12
/// structure is used when the system transforms an EDI (electronic data
/// interchange) file.
///
/// If an EDI input file contains more than one transaction, each transaction
/// must have the same transaction set and version, for example 214/4010. If
/// not, the transformer cannot parse the file.
pub const X12Details = struct {
    /// Returns an enumerated type where each value identifies an X12 transaction
    /// set. Transaction sets are maintained by the X12 Accredited Standards
    /// Committee.
    transaction_set: ?X12TransactionSet,

    /// Returns the version to use for the specified X12 transaction set.
    version: ?X12Version,

    pub const json_field_names = .{
        .transaction_set = "transactionSet",
        .version = "version",
    };
};
