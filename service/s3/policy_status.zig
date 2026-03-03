/// The container element for a bucket's policy status.
pub const PolicyStatus = struct {
    /// The policy status for this bucket. `TRUE` indicates that this bucket is
    /// public.
    /// `FALSE` indicates that the bucket is not public.
    is_public: ?bool = null,
};
