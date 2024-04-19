#!/bin/bash
git add .;
git commit -m "feat:update"
git push github master;
echo "github push finish";
git push ltpp master;
echo "ltpp push finish"