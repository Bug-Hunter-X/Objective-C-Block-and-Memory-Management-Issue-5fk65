To resolve this issue, use weak references within the block to prevent retain cycles. Here's a corrected version:

```objectivec
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)someMethod {
    NSMutableArray *localDataArray = [self.dataArray mutableCopy]; // Create a local copy
    [localDataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        __weak typeof(self) weakSelf = self;  // Create a weak reference to self
        // ... use weakSelf instead of self and handle potential nil checks...
        if (weakSelf) {
          // Access data using weakSelf safely
        }
    }];
}
```

Creating a local copy of `dataArray` prevents direct manipulation of the original array during iteration, and using `__weak typeof(self) weakSelf = self` prevents retain cycles.  Always check for `weakSelf == nil` to handle cases where `self` might have been deallocated before the block completes.