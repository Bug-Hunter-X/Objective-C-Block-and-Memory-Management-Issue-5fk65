In Objective-C, a common yet subtle error arises when dealing with memory management and object lifecycles, especially when using blocks.  Consider this example:

```objectivec
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)someMethod {
    [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // ... some code using 'obj' ...
    }];
}
```

If `obj` is modified within the block in a way that affects its lifecycle (e.g., removing it from `dataArray`), a retain cycle might occur or, worse, the `obj` might be deallocated before the block completes its execution leading to crashes or unexpected behavior.  This is because the block retains `self` (implicitly), and the strong reference in `dataArray` retains `obj`, creating a circular dependency.