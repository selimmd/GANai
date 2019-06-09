# GANai (Standardizing CT image)

Computed tomography (CT) is a widely-used diagnostic image modality routinely used for assessing anatomical tissue characteristics. However, non-standardized imaging protocols are commonplace, which poses a fundamental challenge in large-scale cross-center CT image analysis. This project propsed a GAN based model to standardized the CT images in terms of texture features. 

# Paper: 
https://www.biorxiv.org/content/10.1101/460188v1 

# model Architechture:

In generator part, a U-net is used and the traditional CNN is used in discriminator. But insted of having single generator and discriminator, the GANai has multiple G and D. At the end of the training best G and D is finalized.



# Dataset:

"ganai_delivery.py" contains the implemntation of the paper and "test_train_script.sh" contains the arguments to run the model.
