CONSTRAINT image_image FOREIGN KEY (parent_id)
        REFERENCES public.image (image_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,