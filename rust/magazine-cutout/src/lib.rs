// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let mut map: HashMap<&str, i32> = HashMap::new();

    for word in magazine.iter() {
        map.entry(word)
           .and_modify(|e| { *e += 1 })
           .or_insert(1);
    }
    
    for word in note.iter() {
        map.entry(word)
           .and_modify(|e| { *e -= 1 })
           .or_insert(-1);
        
        if map[word] < 0 { return false; }
    }
    
    true
}
